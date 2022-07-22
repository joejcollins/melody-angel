#[cfg(test)]

use melody_angel::say_hello::worm_greeting;

#[test]
fn shit_equals_hello_worm() {
    assert_eq!(worm_greeting(), "Hello Worm!");
}




