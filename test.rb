require 'gtk2'

class TestView
    def init(controller)
        # TODO: Assert non-nil
        @controller = controller
        @controller.add_view(this)

        @game = nil

        @command_string = nil
        @output_label = nil

        @output = nil # TODO: Remove if uneeded
    end

    def parse_command(command_string)
        command = command_string.slice(/(\S)+/)
        args = command_string.slice(/ (\S)+/)
        case command
        when "show"
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

                # TODO: Run command; this is for testing
                # Thread.new do
                #     @output = `#{@command_string}`
                #     @output_label.text = @output
                # end
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
    tv = TestView.new()
    tv.show
}

vbox = Gtk::VBox.new()
vbox.pack_start btn, :expand => false, :fill => false, :padding => 0

window.add(vbox)
window.show_all

Gtk.main