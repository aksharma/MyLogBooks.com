# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  layout 'standard'

  include AuthenticatedSystem
  before_filter :login_required
  
  def self.auto_complete_for_all(model, *attrs)
  	attrs.each do |attr|
  		self.auto_complete_for model, attr
  	end
  end

#  def self.in_place_edit_for_all(model, *attrs)
#  	attrs.each do |attr|
#  		self.in_place_edit_for model, attr
#  	end
#  end

	def row_totals(rows_in, tot_out)
		for logrow in rows_in
			@numeric_col.each do |fld|
				tot_out[fld] += logrow.send(fld) if logrow.send(fld)
			end
		end
		@numeric_col.each do |fld|
			tot_out[fld] = '' if tot_out[fld] == 0
		end
	end

	def build_pdf(_pdf)
		_pdf.select_font "Helvetica"

plug = <<-'THISLINK'
<c:alink uri="http://www.mylogbooks.com/">MyLogBooks.com</c:alink>
THISLINK

		_pdf.text plug, :font_size => 7, :justification => :left
		
      PDF::SimpleTable.new do |tab|
        tab.title = "PILOT LOGBOOK"
    	tab.title_font_size		= 12
    	tab.title_gap			= 15

	    tab.column_gap			= 1
        tab.column_order		= @col_order
		tab.column_order.each do |h|
			tab.columns[h] = PDF::SimpleTable::Column.new(h) { |col|
	         col.heading = @field_map[h]
	         col.width = @col_width[h] * @pdf_size_multiplier
	         col.heading.justification = :center
	         col.justification = :center
		}
		end

    	tab.heading_font_size	= 7
        tab.show_headings		= true
	    tab.header_gap 			= 0


        tab.show_lines			= :all
        tab.orientation			= :center
        tab.position			= :center

	    tab.row_gap				= 10
	    tab.font_size			= 7

        mydata = @logrows

        tab.data.replace mydata
        tab.render_on(_pdf)
      end
#------------------ TOTALS --------------------------------------------
      PDF::SimpleTable.new do |tab|
	    tab.column_gap			= 1
        tab.column_order		= @numeric_col
		tab.column_order.each do |h|
			tab.columns[h] = PDF::SimpleTable::Column.new(h) { |col|
	         col.heading = @field_map[h]
	         col.width = @col_width[h] * @pdf_size_multiplier
	         col.justification = :center
		}
		end
        tab.column_order		= ["tot_name"] + @numeric_col

		tab.columns["tot_name"] = PDF::SimpleTable::Column.new("tot_name") { |col|
	    col.width = @left_col_size * @pdf_size_multiplier
	    col.justification = :right
		}

        tab.show_headings		= false
	    tab.header_gap 			= 0


        tab.show_lines			= :all
        tab.orientation			= :center
        tab.position			= :center

	    tab.row_gap				= 10
	    tab.font_size			= 7

		@page_totals.each do |k, v|
			@page_totals[k] = '' if @page_totals[k] == 0
		end

        tmp_hash1 = {}
        tmp_hash1["tot_name"] = "Carried Forward:   "
		tmp_hash1.merge! @blank_tot

        tmp_hash2 = {}
        tmp_hash2["tot_name"] = "To Date Totals:   "
		tmp_hash2.merge! @blank_tot

        mydata = [@page_totals, tmp_hash1, tmp_hash2]

        tab.data.replace mydata
        tab.render_on(_pdf)
      end


		_pdf.text("\n\n\n\nI certify that the entries in this log are true\n\n", :font_size => 9, :justification => :left)
		_pdf.text("\n__________________________________________\n", :font_size => 9, :justification => :left)
		_pdf.text("(Pilot's signature)\n", :font_size => 8, :justification => :left)

	end

	def build_csv
		CSV::Writer.generate(@csv_out = "") do |csv|
			csv << @title_rec
			@allrows.each do |logrow|
				row = []
				@col_order.each do |cell|
					row << logrow[cell]
				end
				csv << row
			end
		end
	end

	def load_table_info
		@field_map = Hash.new
		@col_order = Array.new
		@col_width = Hash.new
		@title_rec = Array.new
		@blank_rec = Hash.new
		@numeric_col = Array.new
		@blank_tot = Hash.new
		@page_totals =  {"tot_name" => "Page Totals:   "}
		@grand_totals = {"tot_name" => "Grand Totals:  "}
		@left_col_size = 0					#to figure the offset for totals lines

		pvtloader_x "flt_date","Date", '', 2
		pvtloader_x "make_model", "Make/\nModel", '', 1.5
		pvtloader_x "aircraft_ident", "Aircraft\n Ident.", '', 1.5
		pvtloader_x "from", "From", '', 1.5
		pvtloader_x "dest", "To", '', 1.5
		pvtloader_x "remarks", "Remarks", '', 4

		pvtloader_num "instr_appr", "Instr.\nAppr.", 0, 1.3
		pvtloader_num "landings", "Ldgs.", 0, 1
		pvtloader_num "sel", "SEL", 0.0, 1
		pvtloader_num "mel", "MEL", 0.0, 1
		pvtloader_num "xc", "Cross\nCountry", 0.0, 1.3
		pvtloader_num "pic_xc", "PIC Cross\nCountry", 0.0, 1.7
		pvtloader_num "day", "Day", 0.0, 1
		pvtloader_num "night", "Night", 0.0, 1
		pvtloader_num "actual_ifr", "Actual\nInstr.", 0.0, 1.3
		pvtloader_num "sim_ifr", "Simul.\nInstr.", 0.0, 1.3
		pvtloader_num "dual", "Dual", 0.0, 1
		pvtloader_num "pic", "PIC", 0.0, 1
		pvtloader_num "total", "Total", 0.0, 1
	end


	private

	def pvtloader_x(key, value, default, width)
		pvtloader(key, value, default, width)
		@left_col_size += width
	end

	def pvtloader_num(key, value, default, width)
		pvtloader(key, value, default, width)
		@numeric_col << key
		@page_totals[key] = default
		@grand_totals[key] = default
		@blank_tot[key] = ''
	end

	def pvtloader(key, value, default, width)
		@field_map[key] = value
		@col_order << key
		@col_width[key] = width
		@title_rec << value.gsub(/\n/,' ')
		@blank_rec[key] = ''
	end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
#  protect_from_forgery # :secret => '0492f19f048b95cfa79b7997027c6a00'
end
