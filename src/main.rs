use walkdir::WalkDir;
use std::fs::File;
use std::io::{Read, Write};
use std::env;
use walkdir::DirEntry;

fn is_not_node_modules(entry: &DirEntry) -> bool {
    // Skip entries named "node_modules"
    entry
        .file_name()
        .to_str()
        .map(|name| name != "node_modules")
        .unwrap_or(true)
}

fn main() {
    let args: Vec<String> = env::args().collect();

    let mut pdf_file = std::fs::OpenOptions::new().create(true).write(true).open("./final.txt").unwrap();
    for entry in WalkDir::new(&args[1])
        .into_iter()
        .filter_entry(is_not_node_modules)
        .filter_map(Result::ok) 
    
    {
        let path = entry.path();
        
        if !entry.file_type().is_file() {
            continue;
        }

        if path.extension().and_then(|ext| ext.to_str()) == Some("pyc") {
            continue; 
        }

        println!("Found file: {}", path.display());
        let mut file = File::open(path).unwrap();
        let mut contents = String::new();
        file.read_to_string(&mut contents).expect(&format!("Failed to read {}", path.display()));

        
        pdf_file.write(path.to_str().unwrap().as_bytes()).unwrap();
        pdf_file.write("\n\n\n".as_bytes()).unwrap();    
        pdf_file.write(contents.as_bytes()).expect(&format!("Failed to Write {}", path.display()));
        pdf_file.write("\n\n\n".as_bytes()).unwrap();
            
            ()
    }
}
