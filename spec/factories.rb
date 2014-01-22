FactoryGirl.define do
  factory :person do
    name "alice"
    gender :woman
    team 'ateam'
    start "2010-01-01"
  end
  factory :bob, class: Person do
    name "bob"
    gender :man
    team 'bteam'
    start "2013-01-01"
  end
  factory :carol, class: Person do
    name "carol"
    gender :woman
    team 'cteam'
    start "2010-01-01"
  end
  factory :dan, class: Person do
    name "dan"
    gender :trans
    team 'dteam'
    start "2009-01-01"
  end

  factory :rob, class: Person do
    name 'Rob West'
    gender 'Man'
    team 'Manager'
    start '2013-01-01'
  end
  factory :colin, class: Person do
    name 'Colin Cross'
    gender 'Man'
    team 'Sparkle Motion'
    start '2012-01-01'
  end
  factory :george, class: Person do
    name 'George Shakhnazaryan'
    gender 'Man'
    team 'Channel 4'
    start '2012-01-06'
  end
  factory :p1, class: Person do
    name 'Person 1'
    gender 'A'
    team 'A'
    start '2012-01-01'
  end
  factory :p2, class: Person do
    name 'Person 2'
    gender 'A'
    team 'A'
    start '2012-01-01'
  end
  factory :p3, class: Person do
    name 'Person 3'
    gender 'B'
    team 'B'
    start '2012-01-01'
  end
  factory :p4, class: Person do
    name 'Person 4'
    gender 'B'
    team 'B'
    start '2012-01-01'
  end


  factory :group do
    people {[create(:person), create(:bob), create(:carol), create(:dan)]}
  end
  factory :event do
    name 'test_event'
    groups {[create(:group)]}
  end
end
