require 'pdf/writer'
require 'pdf/simpletable'

      pdf = PDF::Writer.new
      pdf.select_font("Helvetica")

      PDF::SimpleTable.new do |tab|
        tab.title = "PDF User Unit Conversions"
        tab.column_order.push(*%w(from1 to1 from2 to2))

        tab.columns["from1"] = PDF::SimpleTable::Column.new("from1") { |col|
          col.heading = "From"
        }
        tab.columns["to1"] = PDF::SimpleTable::Column.new("to1") { |col|
          col.heading = "To"
        }
        tab.columns["from2"] = PDF::SimpleTable::Column.new("from2") { |col|
          col.heading = "From"
        }
        tab.columns["to2"] = PDF::SimpleTable::Column.new("to2") { |col|
          col.heading = "To"
        }

        tab.show_lines    = :all
        tab.show_headings = true
        tab.orientation   = :center
        tab.position      = :center

        data = [
          { "from1" => "1 point", "to1" => "0.3528 mm",
            "from2" => "1 point", "to2" => "1/72”" },
          { "from1" => "10 mm", "to1" => "28.35 pts",
            "from2" => "", "to2" => "" },
          { "from1" => "A4", "to1" => "210 mm × 297 mm",
            "from2" => "A4", "to2" => "595.28 pts × 841.89 pts" },
          { "from1" => "LETTER", "to1" => "81/2” × 11”",
            "from2" => "LETTER", "to2" => "612 pts × 792 pts" },
          ]

        tab.data.replace data
        tab.render_on(pdf)
      end
      pdf.save_as('table.pdf')