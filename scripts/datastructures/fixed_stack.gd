extends Node

class_name FixedStack

var max_size: int      # Maximum number of elements in the stack.
var buffer: Array      # Underlying array that holds the elements.
var start: int = 0     # Index of the oldest element.
var size: int = 0      # Current number of elements.

# Initialize the stack with a given maximum size.
func _init(max_size: int = 10):
	self.max_size = max_size
	# Pre-allocate the array with null values for efficiency.
	buffer = Array()
	buffer.resize(max_size)

# Push a new element onto the stack.
# If the stack is full, this will replace (overwrite) the oldest element.
func push(item):
	if size < max_size:
		# There's still room, so insert at the logical end.
		buffer[(start + size) % max_size] = item
		size += 1
	else:
		# The stack is full. Overwrite the oldest element.
		# Note: (start + size) mod max_size is equivalent to start when size == max_size.
		buffer[start] = item
		# Move the start pointer to the next oldest element.
		start = (start + 1) % max_size

func is_empty() -> bool:
	return size == 0

func clear() -> void:
	buffer.fill(null)
	size = 0

# Remove and return the most recent element.
# Returns null if the stack is empty.
func pop():
	if is_empty():
		return null
	# Compute the index of the most recent element.
	var index = (start + size - 1) % max_size
	var item = buffer[index]
	buffer[index] = null    # Optional: Clear the slot.
	size -= 1
	return item

# Return (without removing) the most recent element.
func peek():
	if is_empty():
		return null
	var index = (start + size - 1) % max_size
	return buffer[index]

# Utility method: Return the current number of elements.
func count() -> int:
	return size
