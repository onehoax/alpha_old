import { Test, TestingModule } from '@nestjs/testing';
import { UserrolesService } from './userroles.service';

describe('UserrolesService', () => {
  let service: UserrolesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [UserrolesService],
    }).compile();

    service = module.get<UserrolesService>(UserrolesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
