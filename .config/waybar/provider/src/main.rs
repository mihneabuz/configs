mod util;

use std::io;
use std::process::Command;

use const_str::{concat, repeat};
use scanf::sscanf;
use substring::Substring;

use crate::util::ResultBuilder;

const MUTED: char = '';
const VOLUME: char = '';

const MAX_CHARS: usize = 20;
const FULL_BAR: &str = concat!("", repeat!("█", MAX_CHARS - 2), "");

fn get_output() -> io::Result<(f32, bool)> {
    let output = Command::new("wpctl")
        .args(["get-volume", "@DEFAULT_AUDIO_SINK@"])
        .output()
        .map(|out| String::from_utf8(out.stdout).unwrap_or_default())?;

    let mut value = 0.0;
    if sscanf!(&output, "Volume: {}", value).is_ok() {
        return Ok((value, false));
    }

    if sscanf!(&output, "Volume: {} [MUTED]", value).is_ok() {
        return Ok((value, true));
    }

    Err(io::Error::new(io::ErrorKind::Other, "unexpected output"))
}

pub fn main() -> io::Result<()> {
    let (mut value, muted) = get_output()?;
    value = value.min(1.0);

    let icon = if muted { MUTED } else { VOLUME };
    let filled = (MAX_CHARS as f32 * value) as usize;
    let empty = MAX_CHARS - filled;

    ResultBuilder::new()
        .with_text(&format!(
            "{}  {}{}",
            icon,
            &FULL_BAR.substring(0, filled),
            " ".repeat(empty)
        ))
        .with_alt(if muted { "off" } else { "on" })
        .with_class(if muted { "muted" } else { "active" })
        .build()
        .print();

    Ok(())
}
