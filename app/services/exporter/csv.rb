require "csv"

module Exporter
  module CSV
    def self.run(headers, rows)
      ::CSV.generate do |csv|
        csv << headers
        rows.each do |row|
          csv << row
        end
      end
    end
  end
end
