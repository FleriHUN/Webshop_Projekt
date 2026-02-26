import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OrderHistories } from './order-histories';

describe('OrderHistories', () => {
  let component: OrderHistories;
  let fixture: ComponentFixture<OrderHistories>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OrderHistories]
    })
    .compileComponents();

    fixture = TestBed.createComponent(OrderHistories);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
