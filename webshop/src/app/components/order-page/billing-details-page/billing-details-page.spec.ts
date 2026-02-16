import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BillingDetailsPage } from './billing-details-page';

describe('BillingDetailsPage', () => {
  let component: BillingDetailsPage;
  let fixture: ComponentFixture<BillingDetailsPage>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BillingDetailsPage]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BillingDetailsPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
