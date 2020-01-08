python
import sys
import os
sys.path.insert(0, os.path.expanduser('~') + '/dotfiles/eigen-dbg')
from printers import register_eigen_printers
register_eigen_printers (None)
end
