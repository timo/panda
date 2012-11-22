use Pies;
use Panda::Common;

class Panda::Tester does Pies::Tester {
    sub die (Pies::Project $p, $d) is hidden_from_backtrace {
        X::Panda.new($p.name, 'test', $d).throw
    }

    has $.resources;

    method test(Pies::Project $p) {
        indir $!resources.workdir($p), {
            if 't'.IO ~~ :d {
                withp6lib {
                    my $c = "p6prove t";
                    shell $c and die $p, "Tests failed";
                }
            }
        };
    }
}

# vim: ft=perl6
