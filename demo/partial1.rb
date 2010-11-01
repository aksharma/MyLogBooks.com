require 'pdf/writer'

      pdf = PDF::Writer.new

      pdf.text "Using PDF::Writer - In Partial1"
      pdf.line(pdf.absolute_left_margin, pdf.y + 10,
      pdf.absolute_right_margin, pdf.y + 10).stroke
      pdf.top_margin = pdf.y + 20

      File.open("partial1._pc", "wb") { |f| f.write Marshal.dump(pdf) }
