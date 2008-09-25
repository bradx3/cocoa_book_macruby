#
#  AppController.rb
#  p109_challenge
#
#  Created by Brad Wilson on 26/09/08.
#  Copyright (c) 2008 __MyCompanyName__. All rights reserved.
#

class AppController
	def windowWillResize(sender, toSize:size)
		
		size.height = size.width / 2
#		size.width = 2  * size.height
		
		return size
	end
end
