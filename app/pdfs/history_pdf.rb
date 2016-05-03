class HistoryPdf < Prawn::Document
    def initialize(location, item_code)
        super({:page_size => 'A4', :page_layout => :landscape})
        @location = Location.find_by_id(location.id)
        @documents = Document.where(location_id: location.id)
        @item = Item.find_by_code(item_code)
        @lines = Line.where(document_id: document.id, item_id: @item.id)

        @line_total = 0

        document_header
        move_down 20
        document_rows
        table_content
    end

    def document_header
        text " DOCUMENT CODE: " + @document.code, size: 20, style: :bold, align: :left
        text "LOCATION: " + @location.name, size: 12, style: :bold, align: :left
        text "USER: " + @user.username, size: 12, style: :bold, align: :left 
        text "DATE: " + @document.docdate.to_s, size: 12, style: :bold, align: :left
    end

    def document_rows
        @lines.map do |l|
            @item = Item.find_by_id(l.item_id)
            @line_total = l.qtynew.to_s.to_d + l.qtyused.to_s.to_d
            [@item.code,@item.description,l.qtynew,l.qtyused,@line_total,l.comment]
        end
    end

    def line_header
        ["ITEM CODE","ITEM DESCRIPTION","NEW","USED","TOTAL","COMMENT"]
    end

    def table_data
        [line_header, *document_rows] 
    end

    def table_content
        table(table_data) do
            row(0).font_style = :bold
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.header = true
            self.cell_style = { size: 9 }
            self.column_widths = [80,220,40,40,40,260]
        end
    end
end