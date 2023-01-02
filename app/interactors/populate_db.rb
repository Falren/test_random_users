# frozen_string_literal: true

class PopulateDb
  include Interactor::Organizer

  organize PopulateDb::ImportPeople, PopulateDb::CreateFamily
end
