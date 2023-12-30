import { Module } from '@nestjs/common';
import { InjuredclientsService } from './injuredclients.service';
import { InjuredclientsController } from './injuredclients.controller';
import { PrismaModule } from 'src/prisma/prisma.module';

@Module({
  controllers: [InjuredclientsController],
  providers: [InjuredclientsService],
  imports: [PrismaModule],
})
export class InjuredclientsModule {}
