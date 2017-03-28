require 'gtk2'

class TestView
    def init
        @command_string = nil
        @output_label = nil

        @output = nil # TODO: Remove if uneeded
    end

    def show
        # Gtk.init

        # ----- Window -----
        window = Gtk::Window.new("Command Line Interface")
        window.border_width = 10
        # window.signal_connect("destroy") {
        #     Gtk.main_quit
        # }
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

                # TODO: Run command; this is for testing
                Thread.new do
                    @output = `#{@command_string}`
                    puts @output

                    @output_label.text = @output
                end
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

        # Gtk.main
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
    tv = TestView.new
    tv.show
}

vbox = Gtk::VBox.new()
vbox.pack_start btn, :expand => false, :fill => false, :padding => 0

window.add(vbox)
window.show_all

Gtk.main