class PopulateDb
  include Interactor::Organizer

  organize PopulateDb::FetchPeople,
           PopulateDb::InsertPeople,
           PopulateDb::GroupPeople,
           PopulateDb::CreateRelationships
end
