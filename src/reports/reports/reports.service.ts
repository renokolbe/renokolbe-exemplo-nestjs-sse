import { InjectQueue } from '@nestjs/bull';
import { Injectable } from '@nestjs/common';
import { Status } from '@prisma/client';
import { Queue } from 'bull';
import { PrismaService } from 'src/prisma/prisma/prisma.service';

@Injectable()
export class ReportsService {

    constructor(
        private prismaService: PrismaService, 
        @InjectQueue('reports')
        private reportQueueService: Queue)
    {}

    all(){
        return this.prismaService.report.findMany({
            orderBy: {
                created_at: 'desc'
            },
        });
    }

    findOne(id: number){
        return this.prismaService.report.findUnique({
            where: {
                Id: id
            }
        });
    }

    async request(){
        const report = await this.prismaService.report.create({
            data:{
                status: Status.PENDING,
            },
        });
        await this.reportQueueService.add({ reportId: report.Id })
        return report;
    }

    async producer(reportId: number){
        
        console.log('Producer method')
        await sleep(Math.random() * 10000);

        await this.prismaService.report.update({
            where: {
                Id: reportId,
            },
            data: {
                status: Status.PROCESSING
            },
        });

        await sleep(Math.random() * 10000);
        const randomStatus = Math.random() > 0.5 ? Status.DONE : Status.ERROR;

        await this.prismaService.report.update({
            where: {
                Id: reportId,
            },
            data: {
                filename: randomStatus === Status.DONE ? `report-${reportId}.pdf` : null,
                status: randomStatus
            },
        });

    }
}

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms))