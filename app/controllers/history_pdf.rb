class HistoryPdf < Prawn::Document
    def initialize(location_id, item_code)
        super({:page_size => 'A4', :page_layout => :portrait})
        @location = Location.find_by_id(location_id)
        @item = Item.find_by_code(item_code)
        @history = Location.find_by_sql(
        ["SELECT d.code code, l.qtynew, l.qtyused, (IFNULL(l.qtynew,0) + IFNULL(l.qtyused,0)) total
        FROM documents d
        JOIN lines l ON l.document_id = d.id
        JOIN items i on i.id = l.item_id
        WHERE d.location_id = ?
        AND i.code = ?", location_id, item_code])
        
        @line_total = 0
        @qtynew_total = 0
        @qtyused_total = 0

        history_header
        move_down 20
        table_content
    end

    def history_header
        text "ITEM: " + @item.code + " " + @item.description, size: 16, style: :bold, align: :left
        text "LOCATION: " + @location.name, size: 12, style: :bold, align: :left
    end

    def history_rows
        @history.map do |h|
            @line_total = h.qtynew.to_s.to_d + h.qtyused.to_s.to_d
            @qtynew_total += h.qtynew.to_s.to_d
            @qtyused_total += h.qtyused.to_s.to_d
            [h.code,h.qtynew.to_s.to_d,h.qtyused.to_s.to_d,@line_total]
        end
    end

    def total_row
        @line_total = @qtynew_total + @qtyused_total
        ["TOTAL",@qtynew_total,@qtyused_total,@line_total]
    end

    def line_header
        ["DOCUMENT CODE","NEW","USED","TOTAL"]
    end

    def table_data
        [line_header, *history_rows, total_row] 
    end

    def table_content
        table(table_data) do
            row(0).font_style = :bold
            self.row_colors = ["DDDDDD", "FFFFFF"]
            self.header = true
            self.cell_style = { size: 9 }
            self.column_widths = [120,40,40,40]
            columns(1).align = :right
            columns(2).align = :right
            columns(3).align = :right
        end
    end
end