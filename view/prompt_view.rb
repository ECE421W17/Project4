require 'gtk2'

class PromptView
    def initialize(controller)
        # TODO: Assert non-nil
        @controller = controller

        @command_string = nil
        @output_label = nil
        @output = nil
    end

    def parse_command(command_string)
        command_regex = /\S+/
        arguments_regex = /(\s+\S+)+/

        command = command_string.slice(command_regex)
        args = command_string.slice(arguments_regex)
        case command
        when "move"
            if !args.nil?
                args = args.strip

                column_number = args.slice(command_regex)
                @controller.update_model(column_number.to_i)
                    
                return "Adding move to column #{column_number}"
            end
        else
        end

        return "Error: Command not recognized"
    end

    def show
        # ----- Window -----
        window = Gtk::Window.new("Command Line Interface")
        window.border_width = 10
        # -----


        # ----- Text input -----
        entry = Gtk::Entry.new()
        entry.signal_connect("insert-text") do |entry, new_character|
            @command_string = "#{entry.text}#{new_character}"
        end
        entry.signal_connect("delete-text") do |entry, new_size|
            @command_string = "#{entry.text[0..new_size - 1]}"
        end
        entry.signal_connect("key-press-event") do |entry, key|
            if key.keyval == 65293
                @output = parse_command(@command_string)
                @output_label.text = @output
            end
        end
        # -----

        # ----- Label -----
        @output_label = Gtk::Label.new
        # -----

        # ----- Layout -----
        vbox = Gtk::VBox.new()
        vbox.pack_start entry, :expand => false, :fill => false, :padding => 0
        vbox.pack_start @output_label, :expand => false, :fill => false, :padding => 0
        # -----

        window.add(vbox)
        window.show_all 
    end
end