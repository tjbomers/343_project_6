#
#  Game of Life class
#
#  Author(s): Timothy Bomers, Lauren Freeman
#
class GameOfLife

    # Creates getter methods for instance variables @rows and @cols
    attr_reader  :rows, :cols

    # Constructor that initializes instance variables with default values
    def initialize()
        @grid = []
        @rows = 0
        @cols = 0
    end

    # Reads data from the file, instantiates the grid, and loads the
    # grid with data from file. Sets @grid, @rows, and
    # @cols instance variables for later use.
    def loadGrid(file)
        data = IO.read(file)
        tokens = data.strip.split(' ')

        @rows = tokens.shift.to_i
        @cols = tokens.shift.to_i
        @grid = Array.new(@rows){Array.new(@cols)}

        for i in (0...@rows)
            for j in (0...@cols)
                @grid[i][j] =  tokens.shift.to_i
            end
        end

    end

    # Saves the current grid values to the file specified
    def saveGrid(file)
        data = @rows.to_s + ' ' + @cols.to_s

        for i in 0...@rows
            for j in 0...@cols
                data += ' ' + @grid[i][j].to_s
            end
        end

        data += "\n"
        IO.write(file, data)
    end

    # Mutates the grid to next generation
    def mutate()
        # make a copy of grid and fill it with zeros
        temp = Array.new(@rows)
        for i in (0...@rows)
            temp[i] = Array.new(@cols)
            temp[i].fill(0)
        end

        #cycles through all grid elements
        for i in (0...@rows)
          for j in (0...@cols)
              #counts the neighbors of a particular element
              neighbours = getNeighbors(i, j)

              #kills the element if it doesnt have enough neighbours
              if (@grid[i][j] === 1) && (neighbours < 2)
                    temp[i][j] = 0

              #kills the element if it has too many neighbours
              elsif (@grid[i][j] === 1) && (neighbours > 3)
                  temp[i][j] = 0

              #creates a new element if it has enough neighbors
              elsif(@grid[i][j] === 0) && (neighbours == 3)
                  temp[i][j] = 1

              #else keep the grid how it was
              else
                  temp[i][j] = @grid[i][j]
              end
          end
        end

        # DO NOE DELETE: set @grid to temp grid
        @grid = temp
    end

    # Returns the number of neighbors for cell at @grid[i][j]
    def getNeighbors(i, j)
        neighbors = 0

        #cycles through all the neighboring elements, with provisions to not go out-of-bounds
        for iOffset in (-1..1)
            for jOffset in (-1..1)
                if((i + iOffset >= 0) && (j + jOffset >= 0)) && ((i+iOffset < @rows) && (j+jOffset < @cols))
                    #increments neighbors if it finds a correct cell
                    if @grid[i + iOffset][j + jOffset] === 1
                        neighbors += 1
                    end
                end
            end
        end

        #the above loop counts the cell we are looking that.  This catches that
        if @grid[i][j] === 1
              neighbors -= 1
        end

        # DO NOT DELETE THE LINE BELOW
        neighbors
    end

    # Returns a string representation of GameOfLife object
    def to_s
        str = "\n"
        for i in 0...@rows
            for j in 0...@cols
                if @grid[i][j] == 0
                    str += ' . '
                else
                    str += ' X '
                end
            end
            str += "\n"
        end
        str
    end
end
