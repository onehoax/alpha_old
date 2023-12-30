import { Module } from '@nestjs/common';
import { UserrolesService } from './userroles.service';
import { UserrolesController } from './userroles.controller';
import { PrismaModule } from 'src/prisma/prisma.module';

@Module({
  controllers: [UserrolesController],
  providers: [UserrolesService],
  imports: [PrismaModule],
})
export class UserrolesModule {}
