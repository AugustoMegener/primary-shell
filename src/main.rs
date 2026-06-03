use chrono::Local;
use serde::Serialize;
use std::time::Duration;
use tokio::time;

#[derive(Serialize, Clone)]
struct TimeStamp {
    date: String,
    time: String,
}

#[derive(Serialize, Clone)]
struct State {
    time_stamp: TimeStamp,
}

#[tokio::main]
async fn main() {
    let mut interval = time::interval(Duration::from_secs(1));

    loop {
        interval.tick().await;

        let state = State {
            time_stamp: {
                let date_time = Local::now();

                TimeStamp {
                    date: date_time.date_naive().format("%Y-%m-%d").to_string(),
                    time: date_time.time().format("%Hh%M").to_string(),
                }
            },
        };

        println!("{}", serde_json::to_string(&state).unwrap());
    }
}
