require "csv"

class Voter < ActiveRecord::Base

  class << self; attr_accessor :attrs_to_store end
  @attrs_to_store = [:email, :first_name, :last_name, :voter_id]

  attr_accessible *@attrs_to_store

  def self.import_voters_from_csv(document)
    rows = []
    CSV.parse(document) do |row|
      rows << row
    end

    return 0 if rows.empty?

    schema = rows[0].map { |key| key.to_sym }

    voter_rows = rows[1..rows.count]
    voter_count = voter_rows.count

    voter_rows.each do |voter|
      voter_data = Hash[schema.zip(voter)]

      # Filter keys
      filtered_voter_data = voter_data.slice *Voter.attrs_to_store
      filtered_voter_data[:response] = voter_data.to_json

      Voter.create! filtered_voter_data
    end

    return voter_count
  end

end
