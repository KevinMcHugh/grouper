FactoryGirl.define do
  factory :person do
    name "alice"
    gender :woman
    start "2010-01-01"
  end
  factory :bob, class: Person do
    name "bob"
    gender :man
    start "2013-01-01"
  end
  factory :carol, class: Person do
    name "carol"
    gender :woman
    start "2010-01-01"
  end
  factory :dan, class: Person do
    name "dan"
    gender :trans
    start "2010-01-01"
  end
  factory :group do
    people {[create(:person), create(:bob), create(:carol), create(:dan)]}
  end
  factory :event do
    name 'test_event'
    groups [group]
  end
end