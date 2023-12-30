import { Test, TestingModule } from '@nestjs/testing';
import { AthleteclientsController } from './athleteclients.controller';
import { AthleteclientsService } from './athleteclients.service';

describe('AthleteclientsController', () => {
  let controller: AthleteclientsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [AthleteclientsController],
      providers: [AthleteclientsService],
    }).compile();

    controller = module.get<AthleteclientsController>(AthleteclientsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
