import { Test, TestingModule } from '@nestjs/testing';
import { InjuredclientsService } from './injuredclients.service';

describe('InjuredclientsService', () => {
  let service: InjuredclientsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [InjuredclientsService],
    }).compile();

    service = module.get<InjuredclientsService>(InjuredclientsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
