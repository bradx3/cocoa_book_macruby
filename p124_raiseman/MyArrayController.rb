#
#  MyArrayController.rb
#  p124_raiseman
#
#  Created by Brad Wilson on 17/10/08.
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

###
# At the time of writing (20081017) the method described in the book caused MacRuby
# to crash. This is a workaround, but shouldn't be too different from the book really.
#
# I also had trouble making the "Begin Editing on Insert" work at the same time as 
# "Undo insert". I've moved some of the begin editing code into this class and it
# seems to have solved the problem.
###
class MyArrayController < NSArrayController
  attr_accessor :myDocument

  def add(sender)
    super(sender)

    undo = @myDocument.undoManager
    undo.prepareWithInvocationTarget(self).remove(sender)
    undo.setActionName "Insert Person" if !undo.isUndoing
  end
  
  def addObject(person)
    super(person)

    myDocument.startObservingPerson(person)
    rearrangeObjects

    a = arrangedObjects
    row = a.indexOfObjectIdenticalTo(person)
    
    myDocument.tableView.editColumn(0, row:row, withEvent:nil, select:true)
  end

  def remove(sender)
    super(sender)

    undo = @myDocument.undoManager
    undo.prepareWithInvocationTarget(self).add(sender)
    undo.setActionName "Delete Person" if !undo.isUndoing
  end

  def removeObjectAtArrangedObjectIndex(index)
    myDocument.stopObservingPersonAt(index)

    super(index)
  end
end
