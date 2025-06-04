// AslanApp/Model/GrammarContentData.swift
import Foundation

struct GrammarContentData {

    static let allMaterials: [GrammarMaterial] = [
        // --- Materi untuk "Basic Particles" ---
        GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particle は (wa) - Topic Marker",
            explanation: """
            Particle は (wa) is a topic marker. It indicates what the sentence is about.
            It's often translated as "as for..." or "speaking of...".
            When "は" is used as a particle, it is pronounced "wa", not "ha".
            """,
            examples: [
                ExampleSentence(japanese: "わたしはがくせいです。", romaji: "Watashi wa gakusei desu.", english: "I am a student."),
                ExampleSentence(japanese: "これはほんです。", romaji: "Kore wa hon desu.", english: "This is a book."),
                ExampleSentence(japanese: "きょうはいいてんきです。", romaji: "Kyou wa ii tenki desu.", english: "Today, the weather is good.")
            ],
            tip: "Think of は (wa) as gently introducing the main subject you're going to talk about."
        ),
        GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particle が (ga) - Subject Marker",
            explanation: """
            Particle が (ga) is a subject marker. It often indicates the subject of a verb, especially when new information is introduced or when the subject is the answer to a "who" or "what" question.
            It can also emphasize the subject.
            """,
            examples: [
                ExampleSentence(japanese: "ねこがいます。", romaji: "Neko ga imasu.", english: "There is a cat. / A cat exists."),
                ExampleSentence(japanese: "だれがきましたか。", romaji: "Dare ga kimashita ka.", english: "Who came?"),
                ExampleSentence(japanese: "このりんごがおいしいです。", romaji: "Kono ringo ga oishii desu.", english: "This apple is delicious.")
            ],
            tip: "が (ga) often points out *which* specific thing is doing the action or being described."
        ),
        GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particle を (o) - Object Marker",
            explanation: """
            Particle を (o) is an object marker. It indicates the direct object of a transitive verb (a verb that takes an object).
            It shows what the action of the verb is being done to.
            When "を" is used as a particle, it is pronounced "o".
            """,
            examples: [
                ExampleSentence(japanese: "パンをたべます。", romaji: "Pan o tabemasu.", english: "I eat bread."),
                ExampleSentence(japanese: "みずをのみます。", romaji: "Mizu o nomimasu.", english: "I drink water."),
                ExampleSentence(japanese: "ほんをよみます。", romaji: "Hon o yomimasu.", english: "I read a book.")
            ],
            tip: "Look for を (o) after the noun that is directly receiving the action of the verb."
        ),

        // --- Materi untuk "Verb Conjugation" ---
        GrammarMaterial(
            courseTitle: "Verb Conjugation",
            topicTitle: "Present Tense (ます -masu form)",
            explanation: """
            The -masu form (ます) is a polite way to end verbs in the present affirmative tense. It's commonly used in everyday conversation with people you don't know well, or in formal situations.
            To form it, you typically take the dictionary form of the verb and change its ending.
            """,
            examples: [
                ExampleSentence(japanese: "たべます (食べる)", romaji: "tabemasu (taberu)", english: "to eat (polite)"),
                ExampleSentence(japanese: "のみます (飲む)", romaji: "nomimasu (nomu)", english: "to drink (polite)"),
                ExampleSentence(japanese: "いきます (行く)", romaji: "ikimasu (iku)", english: "to go (polite)"),
                ExampleSentence(japanese: "みます (見る)", romaji: "mimasu (miru)", english: "to see/watch (polite)")
            ],
            tip: "The -masu form is a great starting point for learning Japanese verbs as it's versatile and polite."
        ),
        GrammarMaterial(
            courseTitle: "Verb Conjugation",
            topicTitle: "Present Negative (ません -masen form)",
            explanation: """
            The -masen form (ません) is the polite negative form of verbs in the present tense. It's used to say that someone does not do an action, or something is not the case.
            It's formed by changing the -masu (ます) ending to -masen (ません).
            """,
            examples: [
                ExampleSentence(japanese: "たべません", romaji: "tabemasen", english: "do not eat (polite)"),
                ExampleSentence(japanese: "のみません", romaji: "nomimasen", english: "do not drink (polite)"),
                ExampleSentence(japanese: "いきません", romaji: "ikimasen", english: "do not go (polite)"),
                ExampleSentence(japanese: "みません", romaji: "mimasen", english: "do not see/watch (polite)")
            ],
            tip: "Simply swap ます (masu) with ません (masen) to make a polite verb negative."
        ),

        // --- Materi untuk "Sentence Structure" ---
        GrammarMaterial(
            courseTitle: "Sentence Structure",
            topicTitle: "Basic Order: Subject-Object-Verb (SOV)",
            explanation: """
            The most basic Japanese sentence structure is Subject-Object-Verb (SOV).
            This is different from English, which is typically Subject-Verb-Object (SVO).
            Particles mark the role of each noun (e.g., は for topic/subject, を for object).
            """,
            examples: [
                ExampleSentence(japanese: "わたしはパンをたべます。", romaji: "Watashi (S) wa pan (O) o tabemasu (V).", english: "I eat bread."),
                ExampleSentence(japanese: "ねこがさかなをみています。", romaji: "Neko (S) ga sakana (O) o mite imasu (V).", english: "The cat is watching the fish."),
                ExampleSentence(japanese: "たなかさんはほんをよみました。", romaji: "Tanaka-san (S) wa hon (O) o yomimashita (V).", english: "Mr. Tanaka read a book.")
            ],
            tip: "Always look for the verb at the end of a Japanese sentence!"
        ),
        GrammarMaterial(
            courseTitle: "Sentence Structure",
            topicTitle: "Adding か (ka) for Questions",
            explanation: """
            To turn a declarative sentence into a question in Japanese, you typically add the particle か (ka) to the end of the sentence.
            The word order usually doesn't change. Your intonation will also rise at the end.
            """,
            examples: [
                ExampleSentence(japanese: "これはほんですか。", romaji: "Kore wa hon desu ka.", english: "Is this a book?"),
                ExampleSentence(japanese: "パンをたべますか。", romaji: "Pan o tabemasu ka.", english: "Do you eat bread?"),
                ExampleSentence(japanese: "げんきですか。", romaji: "Genki desu ka.", english: "Are you well? / How are you?")
            ],
            tip: "Adding か (ka) is the simplest way to form a yes/no question."
        )
    ]

    // Helper function to get materials for a specific course title
    static func materials(forCourseTitle title: String) -> [GrammarMaterial] {
        return allMaterials.filter { $0.courseTitle == title }
    }
}
