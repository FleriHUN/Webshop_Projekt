import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ParentCategories } from './parent-categories';

describe('ParentCategories', () => {
  let component: ParentCategories;
  let fixture: ComponentFixture<ParentCategories>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ParentCategories]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ParentCategories);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
