import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class TrainersService {
  constructor(private prisma: PrismaService) {}

  findAll() {
    return this.prisma.trainer.findMany({ include: { app_user: true } });
  }
}
