#
#  AppController.rb
#  speech_synth
#
#  Created by Brad Wilson on 25/09/08.
#  Copyright (c) 2008 Brad Wilson.
#
# MIT License:
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

class AppController
	attr_accessor :speaker
	attr_accessor :text_field
	attr_accessor :start_button
	attr_accessor :stop_button
	attr_accessor :table_view
	
	def initialize()
		puts "init"
		@speaker = NSSpeechSynthesizer.new
		@speaker.setDelegate(self)
		
		@voices = NSSpeechSynthesizer.availableVoices
	end

	def awakeFromNib() 
		default_voice = NSSpeechSynthesizer.defaultVoice
		row = @voices.index(default_voice)
		@table_view.selectRow(row, byExtendingSelection:false)
		@table_view.scrollRowToVisible(row)
	end
	
	
	def say(sender)
		str = @text_field.stringValue()
		@speaker.startSpeakingString(str)
		@stop_button.setEnabled(true)
		@start_button.setEnabled(false)
	end
	
	def stop(sender)
		@speaker.stopSpeaking()
	end
	
	def speechSynthesizer(sender, didFinishSpeaking:bool)
		@stop_button.setEnabled(false)
		@start_button.setEnabled(true)
	end
	
	def numberOfRowsInTableView(tableView)
		@voices.length
	end
	
	def tableView(table, objectValueForTableColumn:col, row:row)
		v = @voices[row]
		dict = NSSpeechSynthesizer.attributesForVoice(v)
		return dict["VoiceName"]
	end

	def tableViewSelectionDidChange(sender)
		voice = @voices[@table_view.selectedRow]
		@speaker.setVoice(voice)
	end
end
