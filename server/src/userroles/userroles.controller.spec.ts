import { Test, TestingModule } from '@nestjs/testing';
import { UserrolesController } from './userroles.controller';
import { UserrolesService } from './userroles.service';

describe('UserrolesController', () => {
  let controller: UserrolesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UserrolesController],
      providers: [UserrolesService],
    }).compile();

    controller = module.get<UserrolesController>(UserrolesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
