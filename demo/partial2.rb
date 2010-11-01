require 'pdf/writer'

      pdf = File.open("partial1._pc", "rb") { |f|
        Marshal.load(f.read)
      }
        pdf.text "Second Partial", :font_size => 24, :justification => :center
		pdf.save_as("partial.pdf")
