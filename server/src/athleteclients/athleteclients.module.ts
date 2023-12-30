import { Module } from '@nestjs/common';
import { AthleteclientsService } from './athleteclients.service';
import { AthleteclientsController } from './athleteclients.controller';
import { PrismaModule } from 'src/prisma/prisma.module';

@Module({
  controllers: [AthleteclientsController],
  providers: [AthleteclientsService],
  imports: [PrismaModule],
})
export class AthleteclientsModule {}
