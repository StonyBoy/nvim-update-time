# nvim-update-time

**nvim-update-time** updates Timestamp markers in your files as you save them.

## Features

- Automatically update timestamp in a file when the file is saved.
- Customize the marker used to locate the timestamp.
- Customize the timestamp format.
- Customize the range of lines used to locate the timestamp marker.
- Enable/disable the update of timestamps.
- Force an update of the timestamp in the current buffer using a command.

## Dependencies

You need at least NVIM version 0.8.0 to use this plugin.

## Installation

Add StonyBoy/nvim-update-time to your list of plugins

This is how to add the plugin with Lazy (https://github.com/folke/lazy.nvim):

```lua
  {
    'StonyBoy/nvim-update-time',
    config = function()
      require('nvim-update-time').setup({ last = 5, format = '%Y-%m-%d %H:%M:%S %Z'})
    end,
  },
}
```


## Customization

The plugin accepts a table containing the following properties:

| Property         | Type      | Default value       | Description                                                                                                                                                                                                                            |
| ---------------- | ----------| ------------------- | ---------------------------------------------------------------------- |
| first            | Integer   | 0                   | The first line number in the search range. Zero based.                 |
| last             | Integer   | 10                  | The last line number in the search range. Zero based.                  |
| pattern          | String    | 'Time-Stamp: '      | The text string used to locate the timestamp.                          |
| format           | String    | '%Y-%b-%d %H:%M'    | The format string used to generate the timestamp. See :help strftime   |

## User commands

These are the available user commands:

- ```UpdateTimeToggle``` enable/disable the updating of timestamps in all buffers.
- ```UpdateTimeStamp``` updates the timestamp in the current buffer.

