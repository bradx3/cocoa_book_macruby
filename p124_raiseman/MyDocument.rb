#
#  MyDocument.rb
#  p124_raiseman
#
#  Created by Brad Wilson on 26/09/08.
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

require 'osx/cocoa'

class MyDocument < NSDocument
  attr_accessor :employees
  attr_accessor :tableView
  attr_accessor :employeeController

  def init
    @employees = []
    super
  end

  def windowNibName
    # Implement this to return a nib to load OR implement
    # -makeWindowControllers to manually create your controllers.
    return "MyDocument"
  end

  def dataRepresentationOfType(type)
    # Implement to provide a persistent data representation of your
    # document OR remove this and implement the file-wrapper or file
    # path based save methods.
    return nil
  end

  def loadDataRepresentation_ofType(data, type)
    # Implement to load a persistent data representation of your
    # document OR remove this and implement the file-wrapper or file
    # path based load methods.
    return true
  end
	
  def windowWillReturnUndoManager(sender)
    return undoManager
  end

  def startObservingPerson(person)
    person.addObserver(self, 
                       forKeyPath:"personName",
                       options:NSKeyValueObservingOptionOld,
                       context:nil)
    person.addObserver(self, 
                       forKeyPath:"expectedRaise",
                       options:NSKeyValueObservingOptionOld,
                       context:nil)
  end

  def stopObservingPersonAt(index)
    person = employees[index]

    if person
      person.removeObserver(self, forKeyPath:"personName")
      person.removeObserver(self, forKeyPath:"expectedRaise")
    end
  end

  def changeKeyPath(keyPath, ofObject:obj, toValue:newValue)
    obj.setValue(newValue, forKeyPath:keyPath)
  end

  def observeValueForKeyPath(keyPath, ofObject:object, change:change, context:content)
    undo = undoManager
    oldValue = change[NSKeyValueChangeOldKey]

    undo.prepareWithInvocationTarget(self).changeKeyPath(keyPath, 
                                                         ofObject:object,
                                                         toValue:oldValue)
    undo.setActionName("Edit")

  end

end
