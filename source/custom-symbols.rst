自定义符号
=========

在使用 ``psxy`` 等命令时，除了使用 GMT 内置的符号外，用户还可以自定义符号。

.. TODO::

    尚未完成，欢迎翻译。

Background
----------

The GMT tools :doc:`psxy` and :doc:`psxyz` are capable of using custom
symbols as alternatives to the built-in, standard geometrical shapes
like circles, triangles, and many others. One the command line, custom
symbols are selected via the **-Sk**\ *symbolname*\ [*size*] symbol
selection, where *symbolname* refers to a special symbol definition file
called ``symbolname.def`` that must be available via the standard GMT user paths. Several
custom symbols comes pre-configured with GMT (see
Figure :ref:`Custom symbols <Custom_symbols>`)

.. _Custom_symbols:

.. figure:: /_images/GMT_App_N_1.*
   :width: 500 px
   :align: center

   Custom plot symbols supported by GMT. Note that we only show
   the symbol outline and not any fill. These are all single-parameter symbols.
   Be aware that some symbols may have a hardwired fill or no-fill component,
   while others duplicate what is already available as standard built-in symbols.


You may find it convenient to examine some of these and use them as a
starting point for your own design; they can be found in GMT's
share/custom directory.

The macro language
------------------

To make your own custom plot symbol, you will need to design your own
\*.def files. This section defines the language used to build custom
symbols. You can place these definition files in your current directory
or your .gmt user directory. When designing the symbol, you are doing so
in a relative coordinate system centered on (0,0). This point will be
mapped to the actual location specified by your data coordinates.
Furthermore, your symbol should be constructed within the domain
:math:`{-\frac{1}{2},+\frac{1}{2},-\frac{1}{2},+\frac{1}{2}}`, resulting
in a 1 by 1 relative canvas area. This 1 x 1 square will be scaled to your
actual symbol size when plotted.

Comment lines
~~~~~~~~~~~~~

Your definition file may have any number of comment lines, defined to
begin with the character #. These are skipped by GMT but provides a
mechanism for you to clarify what your symbol does.

Symbol variables
~~~~~~~~~~~~~~~~

Simple symbols, such as circles and triangles, only take a single
parameter: the symbol size, which is either given on the command line
(via **-Sk**) or as part of the input data. However, more complicated
symbols, such as the ellipse or vector symbols, may require more
parameters. If your custom symbol requires more than the single size
parameter you must include the line

    **N**: *n_extra_parameters* [*types*]

before any other macro commands. It is an optional statement in that
*n_extra_parameters* will default to 0 unless explicitly set. By
default the extra parameters are considered to be quantities that should
be passed directly to the symbol machinery. However, you can use the
*types* argument to specify different types of parameters. The available
types are

  **a** Geographic angle, to be converted to map angle given the current
  map projection.

  **l** Length, i.e., an additional length scale (in cm, inch, or point as
  per :ref:`PROJ_LENGTH_UNIT <PROJ_LENGTH_UNIT>`) in addition to the given symbol size.

  **o** Other, i.e., a numerical quantity to be passed to the custom symbol as is.

  **s** String, i.e., a single column of text to be placed by the **l** command.
  Use octal \\040 to include spaces while still remaining a single word.

To use the extra parameters in your macro you address them as $1, $2, etc.

Macro commands
~~~~~~~~~~~~~~

The custom symbol language contains commands to rotate the relative
coordinate system, draw free-form polygons and lines, change the current
fill and/or pen, place text, and include basic geometric symbols as part of the
overall design (e.g., circles, triangles, etc.). The available commands
are listed in Table :ref:`custsymb <tbl-custsymb>`.

.. _tbl-custsymb:

+---------------+------------+----------------------------------------+--------------------------------------------+
| **Name**      | **Code**   | **Purpose**                            | **Arguments**                              |
+===============+============+========================================+============================================+
| rotate        | **R**      | Rotate the coordinate system           | :math:`\alpha`\[**a**]                     |
+---------------+------------+----------------------------------------+--------------------------------------------+
| moveto        | **M**      | Set a new anchor point                 | :math:`x_0, y_0`                           |
+---------------+------------+----------------------------------------+--------------------------------------------+
| drawto        | **D**      | Draw line from previous point          | :math:`x, y`                               |
+---------------+------------+----------------------------------------+--------------------------------------------+
| arc           | **A**      | Append circular arc to existing path   | :math:`x_c, y_c, d, \alpha_1, \alpha_2`    |
+---------------+------------+----------------------------------------+--------------------------------------------+
| stroke        | **S**      | Stroke existing path only              |                                            |
+---------------+------------+----------------------------------------+--------------------------------------------+
| texture       | **T**      | Change current pen and fill            |                                            |
+---------------+------------+----------------------------------------+--------------------------------------------+
| star          | **a**      | Plot a star                            | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| circle        | **c**      | Plot a circle                          | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| diamond       | **d**      | Plot a diamond                         | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| ellipse       | **e**      | Plot a ellipse                         | :math:`x, y, \alpha`,\ *major*,\ *minor*   |
+---------------+------------+----------------------------------------+--------------------------------------------+
| octagon       | **g**      | Plot an octagon                        | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| hexagon       | **h**      | Plot a hexagon                         | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| invtriangle   | **i**      | Plot an inverted triangle              | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| letter        | **l**      | Plot a letter                          | :math:`x, y`,\ *size*, *string*            |
+---------------+------------+----------------------------------------+--------------------------------------------+
| marc          | **m**      | Plot a math arc (no heads)             | :math:`x, y, r, \alpha_1, \alpha_2`        |
+---------------+------------+----------------------------------------+--------------------------------------------+
| pentagon      | **n**      | Plot a pentagon                        | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| plus          | **+**      | Plot a plus sign                       | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| rect          | **r**      | Plot a rectangle                       | :math:`x, y`, *width*, *height*            |
+---------------+------------+----------------------------------------+--------------------------------------------+
| square        | **s**      | Plot a square                          | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| triangle      | **t**      | Plot a triangle                        | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| wedge         | **w**      | Plot a wedge                           | :math:`x, y, r, \alpha_1, \alpha_2`        |
+---------------+------------+----------------------------------------+--------------------------------------------+
| cross         | **x**      | Plot a cross                           | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| x-dash        | **-**      | Plot a x-dash                          | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+
| y-dash        | **y**      | Plot a y-dash                          | :math:`x, y`,\ *size*                      |
+---------------+------------+----------------------------------------+--------------------------------------------+

Note for **R**\: if an **a** is appended then :math:`\alpha` is considered
to be a map azimuth; otherwise it is a Cartesian angle.
For **M**, **T**, and all the lower-case symbol codes you may optionally
append specific pens (with **-W**\ *pen*) and fills (with
**-G**\ *pen*). These settings will override the pens and fills you may
have specified on the command line. Passing **-G**- or **-W**- means no
fill or outline, respectively.

Symbol substitution
~~~~~~~~~~~~~~~~~~~

Custom symbols that need to plot any of the standard geometric symbols
(i.e., those controlled by a single size) can make the symbol code a variable.  By specifying **?** instead
of the symbol codes **a**, **c**, **d**, **g**, **h**, **i**, **n**, **+**, **s**, **t**,
**x**, **-**, or **y** the actual symbol code is expected to be found at the end of
each data record.  Such custom symbols must be invoked with **-SK** rather than **-Sk**.

Text substitution
~~~~~~~~~~~~~~~~~

Normally, the **l** macro code will place a hard-wired text string.  However,
you can also obtain the entire string from your input file via a single symbol
variable that must be declared with type  **s** (string).  The string read
from your input file must be a single word, so if you need spaces you must
use the octal \\040 code.  Similarly, to place the dollar sign $ you must
use octal \\044 so as to not confuse the parser with a symbol variable.
The string itself, if obtained from the symbol definition file,
may contain special codes that will be expanded given the current record.  You
can embed %X or %Y to add the current longitude (or x) and latitude (or y) in
your label string. You may also use $n to embed a numerical symbol variable as text.
It will be formatted according to :ref:`FORMAT_FLOAT_MAP <FORMAT_FLOAT_MAP>`,
unless you append the modifiers **+X** (longitude via :ref:`FORMAT_GEO_MAP <FORMAT_GEO_MAP>`),
**+Y** (latitude via :ref:`FORMAT_GEO_MAP <FORMAT_GEO_MAP>`), or **+T** (calendar time via
:ref:`FORMAT_DATE_MAP <FORMAT_DATE_MAP>` and :ref:`FORMAT_CLOCK_MAP <FORMAT_CLOCK_MAP>`.

Text alignment and font attributes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Like the **Sl** symbol in :doc:`psxy`, you can change the current
font by appending to **l** the modifier **+f**\ *font* [FONT_ANNOT_PRIMARY] and change the text justification
by appending the modifier **+j**\ *justify* [CM]. Note: Here, the *font* specification
will only be considered for the font type and not its size (which is set separately by your *size*
argument) or color and outline (which are set separately by **-G** and **-W** arguments).
Finally, there are two ways to specify the font size.  If a fixed font size is given in points
(e.g,, 12p) then the text will be set at that size regardless of the symbol size specified in **-S**.
Without the trailing **p** we interpret the size as a relative size in the 0-1 range and the actual
font size will then scale with the symbol size, just like other symbol items.

Conditional statements
~~~~~~~~~~~~~~~~~~~~~~

There are two types of conditional statements in the macro language: A
simple condition preceding a single command, or a more elaborate
if-then-elseif-else construct. In any test you may use one (and only
one) of many logical operators, as listed in Table :ref:`custop <tbl-custop>`.

.. _tbl-custop:

+----------------+----------------------------------------------------------+
| **Operator**   | **Purpose**                                              |
+================+==========================================================+
| <              | Is *left* less than *right*?                             |
+----------------+----------------------------------------------------------+
| <=             | Is *left* less than or equal to *right*?                 |
+----------------+----------------------------------------------------------+
| ==             | Is *left* equal to *right*?                              |
+----------------+----------------------------------------------------------+
| !=             | Is *left* not equal to *right*?                          |
+----------------+----------------------------------------------------------+
| >=             | Is *left* greater than or equal to *right*?              |
+----------------+----------------------------------------------------------+
| >              | Is *left* greater than *right*?                          |
+----------------+----------------------------------------------------------+
| %              | Does *left* have a remainder with *right*?               |
+----------------+----------------------------------------------------------+
| !%             | Is *left* an exact multiple of *right*?                  |
+----------------+----------------------------------------------------------+
| <>             | Is *left* within the exclusive range of *right*?         |
+----------------+----------------------------------------------------------+
| []             | Is *left* within the inclusive range of *right*?         |
+----------------+----------------------------------------------------------+
| <]             | Is *left* within the in/ex-clusive range of *right*?     |
+----------------+----------------------------------------------------------+
| [>             | Is *left* within the ex/in-clusive range of *right*?     |
+----------------+----------------------------------------------------------+

Above, *left* refers to one of your variable arguments (e.g., $1, $2) or any constant (e.g. 45) on the left hand side of the operator.
On the right hand side of the operator *right* is either one of your other variables, or a constant, or a range indicated by
two colon-separated constants or variables (e.g., 10:50, $2:60, $3:$4, etc.).

Simple conditional test
^^^^^^^^^^^^^^^^^^^^^^^

The simple if-test uses a one-line format, defined as

    **if** *left* *OP* *right* **then** *command*

where *left* must be one of the symbol parameters, specified as $1, $2,
$3, etc., or a constant. You must document what these additional parameters control. For
example, to plot a small cyan circle at (0.2, 0.3) with diameter 0.4
only if $2 exceeds 45 you would write

    ::

     if $2 > 45 then 0.2 0.3 0.4 c -Gcyan

Note that this form of the conditional test has no mechanism for an
**else** branch, but this can be accomplished by repeating the test but
reversing the logic for the second copy, e.g.,

    ::

     if $1 > 10 then 0 0 0.5 c -Gred
     if $1 <= 10 then 0 0 0.5 c -Gblue

or you may instead consider the complete conditional construct below.
Using a comparison between variables is similarly straightforward:

    ::

     if $2 > $3 then 0.2 0.3 0.4 c -Ggreen

Complete conditional test
^^^^^^^^^^^^^^^^^^^^^^^^^

The complete conditional test uses a multi-line format, such as

| **if** *left* *OP *right* **then** {
|  <one or more lines with commands>
| } **elseif** *left* OP *right* **then** {
|  <one or more lines with commands>
| } **else** {
|  <one or more lines with commands>
| }

The **elseif** (one or more) and **else** branches are optional. Note
that the syntax is strictly enforced, meaning the opening brace must
appear after **then** with nothing following it, and the closing brace
must appear by itself with no other text, and that the **elseif** and
**else** statements must have both closing and opening braces on the
same line (and nothing else). You may nest tests as well (up to 10
levels deep), e.g.,

   ::

    if $1 > 45 then {
            if $2 [> 0:10 then 0 0 0.5 c -Gred
    } elseif $1 < 15 then {
            if $2 [> 0:10 then 0 0 0.5 c -Ggreen
    } else {
            if $2 [> 10:20 then {
                    0 0 M -W1p,blue
                    0.3 0.3 D
                    S
                    0.3 0.3 0.3 c -Gcyan
            }
    }
