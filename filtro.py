def filter_postgres_log(file_path):
    error_levels = ['ERROR', 'FATAL', 'PANIC']
    level_description = {
        'ERROR': 'Error',
        'FATAL': 'Fatal error',
        'PANIC': 'Panic'
    }

    with open(file_path, 'r+') as log_file:
        for line in log_file:
            for level in error_levels:
                if level in line:
                    level_type = level_description.get(level, 'Unknown')
                    print(f"{level_type}: {line.strip()}")

if __name__ == "__main__":
    logfile_path = "/var/lib/postgres"  # Ruta completa del archivo de registro dentro del contenedor
    filter_postgres_log(logfile_path)
