# Sparkle Scripting Language Guide

## Introduction

Sparkle is a lightweight scripting language designed for simple text processing and automation tasks. Scripts are executed line-by-line using the Tulip interpreter.

## Getting Started

### Running a Sparkle Script

```bash
spark script.spark
```

### Your First Script

```sparkle
<greeting>[Hello, World!]
'Welcome to Sparkle!'
&greeting&
```

**Output:**
```
Welcome to Sparkle!
Hello, World!
```

## Language Syntax

### 1. Variable Definitions

Variables are defined using angle brackets and square brackets:

```sparkle
<variable_name>[value]
```

**Examples:**
```sparkle
<name>[Alice]
<age>[25]
<message>[Welcome to Sparkle scripting!]
```

**Rules:**
- Variable names go inside `< >`
- Values go inside `[ ]`
- Variables are stored in memory for the duration of the script
- Variables can be redefined (later definitions overwrite earlier ones)

### 2. Printing String Literals

Print text directly using single quotes:

```sparkle
'text to print'
```

**Examples:**
```sparkle
'Hello, World!'
'This is a simple message'
'Numbers work too: 12345'
```

**Special Behavior:**
If the text inside quotes matches a variable name, the variable's value is printed instead:

```sparkle
<greeting>[Hello!]
'greeting'
```
**Output:** `Hello!`

### 3. Variable Output

Print the value of a variable using ampersands:

```sparkle
&variable_name&
```

**Examples:**
```sparkle
<name>[Bob]
<occupation>[Developer]

&name&
&occupation&
```

**Output:**
```
Bob
Developer
```

**Error Handling:**
- Empty variable references `&&` will cause an error
- Referencing undefined variables will cause an error with line number

### 4. Function Calls

Execute built-in functions using exclamation marks:

```sparkle
!function_name!parameter
```

**Examples:**
```sparkle
!wait!5
!memprint!100
```

## Built-in Functions

### `memprint`

Prints memory-related information.

```sparkle
!memprint!parameter
```

**Parameters:** Numeric value

**Example:**
```sparkle
!memprint!1024
```

### `wait`

Pauses script execution for a specified duration.

```sparkle
!wait!seconds
```

**Parameters:** Number of seconds to wait

**Example:**
```sparkle
'Starting...'
!wait!3
'3 seconds have passed!'
```

## Complete Examples

### Example 1: Simple Greeting

```sparkle
<user>[Alice]
<greeting>[Hello]

'--- Welcome Message ---'
&greeting&
&user&
'--- End Message ---'
```

**Output:**
```
--- Welcome Message ---
Hello
Alice
--- End Message ---
```

### Example 2: Timed Messages

```sparkle
'First message'
!wait!2
'Second message (after 2 seconds)'
!wait!3
'Third message (after 3 more seconds)'
```

### Example 3: Multiple Variables

```sparkle
<firstName>[John]
<lastName>[Doe]
<email>[john.doe@example.com]
<phone>[555-0123]

'Contact Information:'
'Name:'
&firstName&
&lastName&
'Email:'
&email&
'Phone:'
&phone&
```

### Example 4: Variable Overwriting

```sparkle
<status>[Starting]
&status&

<status>[Processing]
&status&

<status>[Complete]
&status&
```

**Output:**
```
Starting
Processing
Complete
```

## Best Practices

### 1. Use Descriptive Variable Names

**Good:**
```sparkle
<userName>[Alice]
<userAge>[25]
```

**Avoid:**
```sparkle
<x>[Alice]
<n>[25]
```

### 2. One Statement Per Line

Sparkle processes line-by-line. Keep your code readable:

```sparkle
<name>[Bob]
'Hello'
&name&
```

### 3. Define Variables Before Use

Always define variables before referencing them to avoid runtime errors:

```sparkle
<greeting>[Hello]
&greeting&
```

### 4. Comment Your Intent

While Sparkle doesn't have built-in comments, you can use string literals as documentation:

```sparkle
'=== Configuration Section ==='
<serverName>[localhost]
<port>[8080]

'=== Display Configuration ==='
&serverName&
&port&
```

## Common Patterns

### Configuration Files

```sparkle
'Loading configuration...'

<appName>[MyApp]
<version>[1.0.0]
<author>[Development Team]

'Application Details:'
&appName&
'Version:'
&version&
'Author:'
&author&
```

### Sequential Processing

```sparkle
'Step 1: Initialize'
<step>[Initializing system]
&step&
!wait!1

'Step 2: Process'
<step>[Processing data]
&step&
!wait!2

'Step 3: Complete'
<step>[Task completed]
&step&
```

### Data Display

```sparkle
<product>[Widget Pro]
<price>[29.99]
<stock>[150]

'Product Catalog Entry:'
'Name:'
&product&
'Price: $'
&price&
'In Stock:'
&stock&
```

## Error Messages

Sparkle provides helpful error messages with line numbers:

### Undefined Variable Error
```
error on line 5: variable userName does not exist
```

### Empty Variable Reference Error
```
error on line 3: empty variable reference
```

## Limitations

- No arithmetic operations
- No conditional logic (if/else)
- No loops
- No string concatenation
- Variables cannot reference other variables during definition
- Function parameters must be alphanumeric
- No multi-line strings
- No escape sequences in strings

## Tips & Tricks

### 1. Simulating Delays in Output

```sparkle
'Starting process...'
!wait!1
'Still working...'
!wait!1
'Almost done...'
!wait!1
'Process complete!'
```

### 2. Creating Structured Output

```sparkle
'╔════════════════════╗'
'║   System Report    ║'
'╚════════════════════╝'

<status>[Online]
<uptime>[99.9%]

'Status:'
&status&
'Uptime:'
&uptime&
```

### 3. Variable Name as Documentation

```sparkle
<lastUpdated_2024_01_15>[System initialized]
&lastUpdated_2024_01_15&
```

## Extending Sparkle

To add custom functions, modify the `standard_functions` library and update the interpreter's function call handler:

```lua
-- In the interpreter
for func, param in line:gmatch("!(.-)!([%d%a]+)") do
    if func == "memprint" then
        standard_functions.memprint(tonumber(param))
    elseif func == "wait" then
        standard_functions.wait(tonumber(param))
    elseif func == "yournewfunc" then
        standard_functions.yournewfunc(tonumber(param))
    end
end
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Script won't run | Ensure file has `.spark` extension and path is correct |
| Variable not found | Check spelling and ensure variable is defined before use |
| Function doesn't work | Verify function name and parameter format |
| Unexpected output | Remember that all matching patterns on a line are executed |

## Quick Reference Card

```
Syntax Element          Format                  Example
─────────────────────────────────────────────────────────────
Variable Definition     <name>[value]           <user>[Alice]
String Literal          'text'                  'Hello'
Variable Output         &name&                  &user&
Function Call           !func!param             !wait!5
```

## Conclusion

Sparkle is designed for simplicity and readability. While it lacks advanced programming features, it excels at simple scripting tasks, configuration management, and sequential text processing.

For questions or issues, refer to the Tulip interpreter documentation or examine the `standardlib` module for available functions.

---

**Happy Sparkling! ✨**
