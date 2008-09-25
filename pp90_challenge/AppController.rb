#
#  AppController.rb
#  pp90_challenge
#
#  Created by Brad Wilson on 25/09/08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

class AppController
	attr_accessor :text_field
	attr_accessor :count_label
	
	def count(sender)
		str = @text_field.stringValue
		@count_label.setStringValue("'#{ str }' has #{ str.length } characters")
	end
end
