defmodule DownloadGoogleExtensions.CLI do
  @moduledoc """
  Command-line tool for downloading Google's Chrome Extensions.

  Usage:

      download_google_extensions [options]

  ## Options

      -h, --help        # Shows this help and exits
      -v, --version     # Shows the program version and exits
      -p, --parallel    # Downloads extensions in parellel (default behaviour)
      -s, --sequential  # Downloads extensions sequentially (slower than parallel but more likely to succeed)
          --serial      # Synonym for --sequential
  """

  @switches [help: :boolean, version: :boolean, parallel: :boolean, sequential: :boolean, serial: :boolean]
  @aliases [h: :help, v: :version, p: :parallel, s: :sequential]

  @extensions %{
    "amp-validator" => "nmoffdblmcmgeicmolmhobpoocbbmknc",
    "bookmark-manager" => "gmlllbghnfkpflemihljekbapjopfjik",
    "chrome-web-store-launcher" => "gecgipfabdickgidpmbicneamekgbaej",
    "chromevox" => "kgejglhpjiefppelpmljglcjbhoiplfn",
    "color-enhancer" => "ipkjmjaledkapilfdigkgfmpekpfnkih",
    "data-saver" => "pfmgfdlgomnbgkofeojodiodmgpgmkac",
    "earth-view-from-google-ea" => "bhloflhklmhfpedakmangadcdofhnnoh",
    "g-suite-training" => "idkloemkmldbemijiamdiolojbffnjlh",
    "go-back-with-backspace" => "eekailopagacbcdloonjhbiecobagjci",
    "google+-notifications" => "boemmnepglcoinjcdlfcpcbmhiecichi",
    "google-+1-button" => "jgoepmocgafhnchmokaimcmlojpnlkhp",
    "google-analytics-debugger" => "jnkmfdileelhofjcijamephohjechhna",
    "google-analytics-opt-out" => "fllaojicojecljbmefodhfapmkghcbnh",
    "google-arts-culture" => "akimgimeeoiognljlfchpbkpfbmeapkh",
    "google-calendar-by-google" => "gmbgaklkmjakoegficnlkhebmhkjfich",
    "google-dictionary-by-goog" => "mgijmajocgfcbeboacabfgobmjgjcoja",
    "google-hangouts" => "nckgahadagoaajjgafhacjanaoiihapd",
    "google-input-tools" => "mclkkofklkfljcocdinagocijmpgbhab",
    "google-keep-chrome-extens" => "lpcaedmchfhocbbapmcbpinfpgnhiddi",
    "google-mail-checker" => "mihcahmgecmbnbcchbopgniflfhgnkff",
    "google-maps-api-checker" => "mlikepnkghhlnkgeejmlkfeheihlehne",
    "google-publisher-toolbar" => "omioeahgfecgfpfldejlnideemfidnkc",
    "google-scholar-button" => "ldipcbpaocekfooobnbcddclnhejkcpn",
    "google-similar-pages" => "pjnfggphgdjblhfjaphkjhfpiiekbbej",
    "google-tasks-by-google" => "dmglolhoplikcoamfgjgammjbgchgjdd",
    "google-tone" => "nnckehldicaciogcbchegobnafnjkcne",
    "google-translate" => "aapbdbdomjkkjkaonfhkkikfgjllcleb",
    "google-voice-by-google" => "kcnhkahnjcbndmmehfkdnkjomaanaooo",
    "google-webspam-report-by" => "efinmbicabejjhjafeidhfbojhnfiepj",
    "high-contrast" => "djcfdncoelnlbldjfhinnjlhdjlikmph",
    "highlight-to-search" => "floipahigmmkfhkoapmnijnlnboniglg",
    "iba-opt-out-by-google" => "gbiekjoijknlhijdjbaadobpkdhmoebb",
    "inbox-by-gmail" => "gkljgfmjocfalijkgoogmfffkhmkbgol",
    "legacy-browser-support" => "heildphpnddilhkemkielfhnkaagiabh",
    "mindful-break" => "onjcfgnjjbnflacfbnjaapcbiecckilk",
    "password-alert" => "noondiphcddnnabmjcihcjfbhfklnnep",
    "personal-blocklist-by-goo" => "nolijncfnkgaikbjbdaogikpmpbdcdef",
    "rss-subscription-extensio" => "nlbjncdgjeocebhnmkbbbdekmmmcbfjd",
    "saml-sso-for-chrome-apps" => "aoggjnmghgmcllfenalipjhmooomfdce",
    "save-to-google-drive" => "gmbmikajjgmnabiglmofipeabaddhgne",
    "search-by-image-by-google" => "dajedkncpodkggklbegccjpmnglmnflm",
    "send-from-gmail-by-google" => "pgphcomnlaojlmmcjmiddhdapjpbgeoc",
    "share-to-classroom" => "adokjfanaflbkibffcbhihgihpgijcei",
    "tag-assistant-by-google" => "kejbdjndbnbjgmefkgdddjlbokphdefk",
  }

  @spec main(OptionParser.argv) :: :ok
  def main(args) do
    args |> parse_args |> process
  end

  defp parse_args(args) do
    {opts, _} = OptionParser.parse!(args, strict: @switches, aliases: @aliases)

    cond do
      opts[:help] ->
        IO.puts @moduledoc
        System.halt(0)
      opts[:version] ->
        IO.puts Application.get_env(:download_google_extensions, :version)
        System.halt(0)
      true ->
        opts
    end
  end

  defp process([{opt, true}]) when opt in [:sequential, :serial], do:
    Enum.each(@extensions, &download_extensions/1)
  defp process(_args), do:
    Parallel.pmap(@extensions, &download_extensions/1)

  defp download_extensions({name, id}) do
    opts = [cd: "extensions", stderr_to_stdout: true]
    with {_, 0} <- System.cmd("mkdir", ["-p", "extensions"]),
         {_, 0} <- System.cmd("curl", ["--silent", "--output", "_#{name}.zip", "--location", url(id)], opts),
         {_, 0} <- System.cmd("zip", ["--fix", "_#{name}.zip", "--out", "#{name}.zip"], opts),
         {_, 0} <- System.cmd("unzip", ["-q", "-d", name, "#{name}.zip"], opts),
         {_, 0} <- System.cmd("rm", ["_#{name}.zip", "#{name}.zip"], opts),
         do: IO.puts name
  end

  defp url(extension_id), do:
    ~s"""
    https://clients2.google.com/service/update2/crx?
    response=redirect&
    os=mac&
    arch=x86-64&
    nacl_arch=x86-64&
    prod=chromecrx&
    prodchannel=stable&
    prodversion=44.0.2403.130&
    x=id%3D#{extension_id}%26uc
    """ |> String.replace("\n", "")
end

defmodule Parallel do
  def pmap(collection, func) do
    collection
    |> Enum.map(&(Task.async(fn -> func.(&1) end)))
    |> Enum.map(&Task.await(&1, 30_000))
  end
end
