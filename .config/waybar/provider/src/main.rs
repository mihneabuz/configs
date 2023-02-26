mod audio;
mod util;

use std::process;
use std::env;
use std::io;

fn main() -> io::Result<()> {
    let args = env::args().collect::<Vec<_>>();
    if args.len() < 2 {
        process::exit(1);
    }

    match args[1].as_str() {
        "volume" => audio::volume()?,
        "muted" => audio::muted()?,
        _ => process::exit(1)
    }

    Ok(())
}
