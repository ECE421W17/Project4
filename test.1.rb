require 'gtk2'

# TODO: Remove?
require_relative 'controller/controller.rb'
require_relative 'model/otto_n_toot.rb'

class TestView
    def init(controller)
        # TODO: Assert non-nil
        @controller = controller
        
        # TODO: Remove? Is this needed? Or inconsistent with MVC?
        # @controller.add_view(this)
        @game = nil

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

                player_number = args.slice(command_regex)
                column_number = args.slice(arguments_regex)
                if !column_number.nil?
                    column_number = column_number.strip

                    # @game.make_move(player_number, column_number) # TODO: Do this
                    # @controller.notify(player_number, column_number) # Or this (?) - preferably this
                    
                    return "Adding move to column #{column_number} for player #{player_number}" 
                end
            end
        when "show"
            # TODO: Implement?
            if !args.nil?
                return "show command: #{args.strip}"
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

    def update(new_model)
        # TODO: Remove
        puts "Updating..."

        @game = new_model
    end
end

Gtk.init

window = Gtk::Window.new("Command Line Interface")
window.border_width = 10
window.signal_connect("destroy") {
    Gtk.main_quit
}

btn = Gtk::Button.new("Test")
btn.signal_connect("clicked") {
    # tv = TestView.new() # TODO: Pass in controller
    # tv.show

    # game = Game.new([], 7, 8, [:Colour1, :Colour2], "VirtualPlayer")
    game = OttoNToot.new([], 7, 8, [:O, :T], "2Player", "VirtualPlayer")

    controller = Controller.new([], game)

    tv = TestView.new(controller)

    controller.add_view(tv)

    tv.show
}

vbox = Gtk::VBox.new()
vbox.pack_start btn, :expand => false, :fill => false, :padding => 0

window.add(vbox)
window.show_all

Gtk.main