import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaModule } from './prisma/prisma.module';
import { UsersModule } from './users/users.module';
import { UserrolesModule } from './userroles/userroles.module';
import { RolesModule } from './roles/roles.module';
import { TrainersModule } from './trainers/trainers.module';
import { ClientsModule } from './clients/clients.module';
import { InjuredclientsModule } from './injuredclients/injuredclients.module';
import { AthleteclientsModule } from './athleteclients/athleteclients.module';

@Module({
  imports: [PrismaModule, UsersModule, UserrolesModule, RolesModule, TrainersModule, ClientsModule, InjuredclientsModule, AthleteclientsModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
