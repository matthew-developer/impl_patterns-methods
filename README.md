# Implementation patterns

## Chapter 8 - Methods

### Composed method

> Composed method out of calls to other methods

Composed Method should based on facts not speculations. 
Method should consist of other method calls at roughly the same level of abstraction. 
It should contain one brainful of detail - do only one thing(can consist of many steps) and has closely related detail.
Separate main flow from exceptional flows. 

In this method we have a nice symmetry between three methods. We could consider to convert iv_id to stored value as a field. 
The problem here is, that we have a mix of high level and low level abstraction. In this case you should keep the same level and follow the Step Down Rule to maximize clarity. 

```
METHOD calculate_salary.
    calculate_bonus( iv_id ).
    calculate_taxes( iv_id ).
    mv_salary = mv_salary + 120.
ENDMETHOD.
```

### Intention-Revealing Names

> Name Methods after what they are intended to do. 


First option ist to communicate the intent of the method, not encode any implementation details into the name. If somebody would like to check it, than he can look at the body of the method. 

```
mo_content->create_xml_content( mv_id ).
mo_content->create_content( mv_id ).
mo_customer->linearCustomerSearch( mv_id ).
mo_customer->find( mv_id ).


```

Second option communicates other information in other way - Implementation Strategy. 

```
mo_content->create_output_content( mv_id ).
mo_customer->find( mv_id ).
mo_customer->fastFind( mv_id ).

```

### Method visibility 

> Make Methods as private as possible

Visibility reveals the intention, more methods reveals to outside decrease flexibility. Every change breaks the callers. Just try to reveal as little as possible. Use restrictive visibility at the beginning. If neccessary reveal it as public, after that you may recognise, that it belongs to an interface or abstract class. 


```
PUBLIC SECTION.
METHODS: calculate_salary
            IMPORTING iv_id TYPE i.
PRIVATE SECTION. 
  METHODS: calculate_bonus 
                IMPORTING iv_id TYPE i,
           calculate_taxes 
                IMPORTING iv_id TYPE i.
```

### Method objects

> Turn complex methods into their own objects. 

1. Create a class named after the method. 
2. Create fields in the class for each method's parameters. 
3. Create constructor and initialize all instance fields. 
4. Copy method body into a new method in the class. All importing parameters become fields. 
5. Replace the old method body with the delegation principle. 

```
DATA(mo_salary) = new ycl_salary(  ).
mv_salary = mo_salary->calculate_salary( iv_salary = mv_salary iv_id = iv_id ).
```

### Overridden Method

> Override methods to express specialization 

Well composed methods in the superclass give you enabling points for many variations - template design pattern. 
Invoke superclass method only in the same method of subclass. Don't copy large superclass methods to subclasses, someone changed the superclass and subclass won't work any more - programming by coincidence. 

### Overloaded Method

> Provide alternative interfaces to the same computation. 

Not possible like in other programming languages. The only option is to use methods arguments as optional. 

```
METHODS: calculate_expenses
            IMPORTING iv_id TYPE i OPTIONAL
                      iv_name TYPE string OPTIONAL.
                      
calculate_expenses( iv_id = 5 ).
calculate_expenses( iv_name = 'Johnson' ).
```

### Method Return Types

> Declarethe most general possible return type

Functions have a return parameter. Procedures don't. Pick up just the most abstract return type. It will provide flexibility in the future, but also hides the implementation detail. Return interfaces instead of conrete Objects. 

With interfaces it will be working fine, but the return type must be fully typed. You can do it for Importing arguments.  

```
METHOD: compute_expenses
            IMPORTING iv_expenses TYPE i.
            
METHOD: compute_expenses
            IMPORTING iv_expenses TYPE int8.                  
                      
METHOD: compute_expenses
            IMPORTING iv_expenses TYPE decfloat16.  
            
METHOD: compute_expenses
            IMPORTING iv_expenses TYPE numeric. 
```

### Method Comment

> Comment methods to communicate information not easily read from the code. 

Don't use comments, the code should be self explaining. Use comments for documentation or for writing to-do list. You can use comments also for declaring some unit methods, cause of restriction of 30 characters. 

```
"TO-DO: make the return parameter more abstract
METHODS: compute_expenses
            IMPORTING iv_expenses TYPE i.

METHODS: 
    "It should convert
     integer_to_string FOR TESTING. 

```

### Helper Method

> Create small, private methods to express the main computation more succinctly. 

Follow the Single Responsibility Principle for the methods. Try to hide irrelevant details. Express your intention with meaningful method names. There is only one reason to change a method. If you would like to change the header, than you change the generate_header() without changing other methods. You can use delegation principle for it. 

```
METHOD generate_output. 
    generate_header( ).
    generate_content( ).
    generate_footer( ).
ENDMETHOD.

METHOD generate_content. 
    mt_output-header = mo_header->generate_header( ).
ENDMETHOD.

```

### Conversion Methods

> For simple, limited conversions, provide a method on the source object that returns the converted object. 

Express conversion between objects. Methods convert source object into destination. Unbounded number of potential conversions becomes unwiedly. 

```
METHODS: convert_to_bitcoin
            RETURNING VALUE(ro_bitcoin) TYPE REF TO ycl_bitcoin.
```

### Conversion Constructors

> For most conversions, provide a method on the voncerted object's class that takes the source objcet as a paramater

The object String could have n converted methods. It would be definetly too much. In this case a better way is to create objects for conversion. Constructor can only return full formed objects.


### Complete Constructor

> Write constructors that return fully formed objects. 

Try to create object, that store all neccessary values as instance fields. If the constructor is too long, maybe try to create some helper objects. Remember, that data should be tight coupled. Constructors are methods, but don't apply arguments list rules for them. They are methods, that construct object and return it explicity, that means the constructor has some return parameter. 

```
DATA(lo_rectangle) = new ycl_rectangle( iv_left = 0  iv_top = 0 iv_width = 50 iv_height = 200 ).
```

If the list of parameters get unhandlable make a try to set all neccessary values with help of accessor methods. However this approach can be very dangerous, because it doesn't communicate what combination of parameters is required. 

```
DATA(lo_rectangle) = new ycl_rectangle(  ).
lo_rectangle->set_left( 0 ).
lo_rectangle->set_width( 50 ).
lo_rectangle->set_height( 200 ).
lo_rectangle->set_top( 0 ).
```

### Factory Method

> Express more complex creation as a static method on a class rather than a constructor. 
> More complex factory includes more options
> Builder Design Pattern is also some option to get rid of complexity of creation. 

If the creation of the object contains some additional steps, maybe it is a good idea to use static factory method for it, just  to communicate, that there is something more. In oder case static factory methods can return more abstract types(subclass or implementation of an interface).

```
DATA(lo_rectangle) = ycl_rectangle=>create( iv_left = 0  iv_top = 0 iv_width = 50 iv_height = 200 ).
``` 

### Internal Factory

> Encapsulate in a helper method object creation that may need explanation or later refinement. 

This internal factories are a common part of lazy initialization for objects or if some calculation seems to be complicated. 
The method can be overridden in the subclass and the main algorithm can be used to create some obje

```
METHOD getX. 
    IF ( mv_point_x IS NOT INITIAL ). 
        rv_point_x = mv_point_x.
    ELSE.
        rv_point_x = complicated_operation( ).
    ENDIF.
ENDMETHOD.
```

### Collection Accessor Method

> Provide methods that allow limited access to collections. 

Information Hiding is one of the most important principles. Don't give the caller object full access to some sensitiv data structures. 
It could just break some invariants in your class. Thats the problem of accessor methods. The same is for object this, you give the whole access to yourobject somewhere outside. If the caller just need some data to make complicated operations, thas it's ok, but what if it changes the state of the object and you don't even recognize it? Check if objects can be changed, other structures can't. 

On the other hand we are breaking here Tell don't ask principle. 

```
METHODS: get_books
            RETURNING VALUE(rt_books) TYPE tt_books. 
            
METHOD compute_units. 
    rv_unit_size = mo_helper_object->compute_units( this ).
ENDMETHOD.
```

Provide better some main function for the caller like adding or deleting items in collections. 

```
METHODS: add_book
            IMPORTIONG is_book TYPE ts_books. 
            
METHOD add_book. 
    DELETE mt_books WHERE bookname = is_book-bookname. 
ENDMETHOD.

METHODS: get_books_number
            RETURNING VALUE(rv_number_of_books) TYPE i. 
            
METHOD get_books_number. 
    rv_number_of_books = lines( mt_books ).
ENDMETHOD.
```

If the caller need the collection, than you can provide only an iterator or just give the whole collection, but block accessor methods to set the instance fields - allow only constructor creation for object. 


### Boolean Setting Method

> If it helps communication, provide two methods to set boolean values, on for each state. 

You can set some boolean state in a class like in the example below. However you have always to pass boolean argument to the method. There are only two possibilities abap_true or abap_false. Procedure with one parameter is great, but without any parameters is awsome. 

```
METHODS: set_valid
            IMPORTING iv_state TYPE abap_bool. 
```

So just try to store these two parameters as constants in the class and set status within the method. Is the method is_invalid really neccesseary? We can make operations only on is_valid( ), so don't reapeat some knowledge. 

```
METHODS: is_valid, 
         is_invalid.
```

If you see some the code like below one, provide better the option with set_Valid( boolean newState ). It will costs you only one line of code. 

```
...
IF bolean expression.
    mo_cache->valid( ).
ELSE. 
    mo_cache->invalid( ).
ENDIF.  

...
mo_cache->set_valid( bollean expression ).

```

### Query Method

> Return boolean values with methods named asYYY. 

Sometimes it is neccessary to break the Tell don't ask principle. It means that one object needs the information of the state of other object to make its own complicated calculations. If your object just provide such a protocoll, than the methods should have prefix like isYYY( ), wasYYY( ) or hasYYY( ).

```
IF mo_cache->is_invalid( ).
    send_error_message( ).
ELSE. 
    launch_memory( ).
ENDIF.  

```

But if all operations are outside of your main object, than it's a design problem. It's like you are controlling the object and it can't decide alone about decisions. 

```
IF mo_cache->is_invalid( ).
    mo_cache->do_something( ).
ELSE. 
    mo_cache->do_something_else( ).
ENDIF.  

...
mo_cache->operate( ).

```

### Getting Method

> Occasionally provide access to fields with a method that returning that field.

One way of access the object's state is to call a getter method. However if you put logic&data together there should be no need for accessor methods. Instead of writign a gettter method or making it public just try to move the logic to the place, where the data is used instead. 

Some exceptions are algorithms located in their own objects. They need access to data in order to make computation. 

### Setting Method

> Even less frequently providethe ability to set fields with a method. 

If you have to set a field of a class use a accessor method with the right convention. For this reason try to name the method after its implementation. 

```
METHOD set_point_x. 
    mv_point_x = iv_point_x. 
ENDMETHOD.
```

Don't make the setting methods visible, because they are named after implementetion not intention. For the client is much more important the intention. Try to use composed method principle to make the mehtod more specific for the client's call. 

```
METHOD center_paragraph. 
    set_justification( mc_centered ).
ENDMETHODN.
```

Setter Methods should set a field of a class, but also update all other fields which are closle coupled. So update dependent information.

```
METHOD set_justification.
    ...
    redisplay(  ).
ENDMETHODN.
```
