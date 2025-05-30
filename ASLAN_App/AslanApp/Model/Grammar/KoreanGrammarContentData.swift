import Foundation

struct KoreanGrammarContentData {

    static let allMaterials: [GrammarMaterial] = [ // Menggunakan struktur GrammarMaterial yang ada
        // --- Materi untuk "Basic Particles" ---
        GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particles 은/는 (eun/neun) - Topic Marker",
            explanation: """
            Particles 은 (eun) and 는 (neun) are topic markers. They indicate what the sentence is about, similar to Japanese は (wa).
            은 (eun) is used after a noun ending in a consonant.
            는 (neun) is used after a noun ending in a vowel.
            They set the stage, saying "As for..." or "Speaking of...".
            """,
            examples: [
                ExampleSentence(japanese: "저는 학생입니다.", romaji: "Jeo-neun haksaeng-imnida.", english: "I am a student. (As for me...)"), // Menggunakan 'japanese' untuk Hangul
                ExampleSentence(japanese: "이것은 책입니다.", romaji: "Igeot-eun chaek-imnida.", english: "This is a book."),
                ExampleSentence(japanese: "오늘은 날씨가 좋습니다.", romaji: "Oneul-eun nalssi-ga jotseumnida.", english: "Today, the weather is good.")
            ],
            tip: "Think of 은/는 as highlighting the main character of your sentence's story."
        ),
        GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particles 이/가 (i/ga) - Subject Marker",
            explanation: """
            Particles 이 (i) and 가 (ga) are subject markers, similar to Japanese が (ga). They often identify the subject performing an action or being described, especially when introducing new information.
            이 (i) is used after a noun ending in a consonant.
            가 (ga) is used after a noun ending in a vowel.
            """,
            examples: [
                ExampleSentence(japanese: "고양이가 있습니다.", romaji: "Goyangi-ga itseumnida.", english: "There is a cat."),
                ExampleSentence(japanese: "누가 왔습니까?", romaji: "Nuga watsseumnikka?", english: "Who came?"),
                ExampleSentence(japanese: "이 사과가 맛있습니다.", romaji: "I sagwa-ga masitseumnida.", english: "This apple is delicious.")
            ],
            tip: "이/가 often answers the 'who' or 'what' question about the verb."
        ),
         GrammarMaterial(
            courseTitle: "Basic Particles",
            topicTitle: "Particles 을/를 (eul/reul) - Object Marker",
            explanation: """
            Particles 을 (eul) and 를 (reul) mark the direct object of a verb, similar to Japanese を (o). They show what receives the action.
            을 (eul) is used after a noun ending in a consonant.
            를 (reul) is used after a noun ending in a vowel.
            """,
            examples: [
                ExampleSentence(japanese: "빵을 먹습니다.", romaji: "Ppang-eul meokseumnida.", english: "I eat bread."),
                ExampleSentence(japanese: "물을 마십니다.", romaji: "Mul-eul masimnida.", english: "I drink water."),
                ExampleSentence(japanese: "책을 읽습니다.", romaji: "Chaek-eul ikseumnida.", english: "I read a book.")
            ],
            tip: "Look for 을/를 after the noun being acted upon."
        ),

        // --- Materi untuk "Verb Conjugation" ---
        GrammarMaterial(
            courseTitle: "Verb Conjugation",
            topicTitle: "Present Tense (ㅂ니다/습니다 -mnida/seumnida)",
            explanation: """
            The -ㅂ니다/습니다 (-mnida/seumnida) form is a formal, polite way to end verbs in the present tense in Korean. It's often used in formal presentations, news broadcasts, and the military, but also in polite initial interactions.
            -ㅂ니다 is added to verb stems ending in a vowel.
            -습니다 is added to verb stems ending in a consonant.
            """,
            examples: [
                ExampleSentence(japanese: "먹습니다 (먹다)", romaji: "meokseumnida (meokda)", english: "to eat (formal polite)"),
                ExampleSentence(japanese: "마십니다 (마시다)", romaji: "masimnida (masida)", english: "to drink (formal polite)"),
                ExampleSentence(japanese: "갑니다 (가다)", romaji: "gamnida (gada)", english: "to go (formal polite)"),
                ExampleSentence(japanese: "봅니다 (보다)", romaji: "bomnida (boda)", english: "to see/watch (formal polite)")
            ],
            tip: "This form is very polite but less common in everyday casual conversation than the -아요/어요 (-ayo/eoyo) form."
        ),

        // --- Materi untuk "Sentence Structure" ---
        GrammarMaterial(
            courseTitle: "Sentence Structure",
            topicTitle: "Basic Order: Subject-Object-Verb (SOV)",
            explanation: """
            Similar to Japanese, the basic Korean sentence structure is Subject-Object-Verb (SOV).
            Particles mark the function of each noun (e.g., 은/는 for topic, 이/가 for subject, 을/를 for object).
            """,
            examples: [
                ExampleSentence(japanese: "저는 빵을 먹습니다.", romaji: "Jeo (S) -neun ppang (O) -eul meokseumnida (V).", english: "I eat bread."),
                ExampleSentence(japanese: "고양이가 생선을 봅니다.", romaji: "Goyangi (S) -ga saengseon (O) -eul bomnida (V).", english: "The cat watches the fish."),
                ExampleSentence(japanese: "김 씨는 책을 읽었습니다.", romaji: "Gim ssi (S) -neun chaek (O) -eul ilgeotsseumnida (V).", english: "Mr. Kim read a book.")
            ],
            tip: "The verb always comes last in a basic Korean sentence!"
        ),
         GrammarMaterial(
            courseTitle: "Sentence Structure",
            topicTitle: "Adding 까 (kka) for Questions",
            explanation: """
            To turn a formal declarative sentence (ending in -ㅂ니다/습니다) into a question, you change the ending to -ㅂ니까/습니까 (-mnikka/seumnikka).
            The word order generally remains the same.
            """,
            examples: [
                ExampleSentence(japanese: "이것은 책입니까?", romaji: "Igeot-eun chaegimnikka?", english: "Is this a book?"),
                ExampleSentence(japanese: "빵을 먹습니까?", romaji: "Ppang-eul meokseumnikka?", english: "Do you eat bread?"),
                ExampleSentence(japanese: "안녕하십니까?", romaji: "Annyeonghasimnikka?", english: "How are you? / Hello (Formal)")
            ],
            tip: "Just change 다 (da) to 까 (kka) at the end for formal questions."
        )
    ]

    static func materials(forCourseTitle title: String) -> [GrammarMaterial] {
        return allMaterials.filter { $0.courseTitle == title }
    }
}
