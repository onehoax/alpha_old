import { Test, TestingModule } from '@nestjs/testing';
import { InjuredclientsController } from './injuredclients.controller';
import { InjuredclientsService } from './injuredclients.service';

describe('InjuredclientsController', () => {
  let controller: InjuredclientsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [InjuredclientsController],
      providers: [InjuredclientsService],
    }).compile();

    controller = module.get<InjuredclientsController>(InjuredclientsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
