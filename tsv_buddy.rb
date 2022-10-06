# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data

TAB = "\t"
NEWLINE = "\n"

# Service to embbed the tsv function
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    rows = tsv_to_array(tsv)
    headers = rows.first
    @data = rows[1..].map do |row|
      row_to_hash(row, headers)
      # row.map.with_index { |cell, i| [headers[i], cell] }.to_h
    end
  end

  def tsv_to_array(tsv)
    tsv.split(NEWLINE).map { |line| line.split(TAB) }
  end

  def row_to_hash(row, headers)
    row.map.with_index { |cell, i| [headers[i], cell] }.to_h
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    rowzero = @data.first.keys
    header_data = single_line_to_tsv(rowzero)
    "#{rows_aggregate(header_data)}\n"
  end

  def single_line_to_tsv(row)
    row.reduce do |origndata, appenddata|
      "#{origndata}\t#{appenddata}"
    end
  end

  def rows_aggregate(header_data)
    @data.reduce(header_data) do |origndata, appenddata|
      "#{origndata}\n#{single_line_to_tsv(appenddata.values)}"
    end
  end
end
