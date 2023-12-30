import { Test, TestingModule } from '@nestjs/testing';
import { AthleteclientsService } from './athleteclients.service';

describe('AthleteclientsService', () => {
  let service: AthleteclientsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [AthleteclientsService],
    }).compile();

    service = module.get<AthleteclientsService>(AthleteclientsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
