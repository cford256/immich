<script lang="ts">
  import { goto } from '$app/navigation';
  import AdminPageLayout from '$lib/components/layouts/AdminPageLayout.svelte';
  import GroupAvatar from '$lib/components/shared-components/GroupAvatar.svelte';
  import { AppRoute } from '$lib/constants';
  import GroupEditModal from '$lib/modals/GroupEditModal.svelte';
  import { deleteGroupAdmin } from '@immich/sdk';
  import { Button, Card, CardBody, Code, Container, Heading, HStack, modalManager, Stack, Text } from '@immich/ui';
  import { mdiPencilOutline, mdiTrashCanOutline } from '@mdi/js';
  import { t } from 'svelte-i18n';
  import type { PageData } from './$types';

  interface Props {
    data: PageData;
  }

  let { data }: Props = $props();

  let group = $derived(data.group);

  const handleEdit = async () => {
    const result = await modalManager.show(GroupEditModal, { group });
    if (result) {
      group = result;
    }
  };

  const handleDelete = async () => {
    const confirmed = await modalManager.showDialog({
      prompt: $t('confirm_delete_name', { values: { name: group.name } }),
      confirmColor: 'danger',
      icon: mdiTrashCanOutline,
    });

    if (confirmed) {
      await deleteGroupAdmin({ id: group.id });
      await goto(AppRoute.ADMIN_GROUPS);
    }
  };
</script>

<AdminPageLayout title={data.meta.title}>
  {#snippet buttons()}
    <HStack gap={0}>
      <Button
        color="secondary"
        size="small"
        variant="ghost"
        leadingIcon={mdiPencilOutline}
        onclick={() => handleEdit()}
      >
        <Text class="hidden md:block">{$t('edit_group')}</Text>
      </Button>
      <Button
        color="danger"
        size="small"
        variant="ghost"
        leadingIcon={mdiTrashCanOutline}
        onclick={() => handleDelete()}
      >
        <Text class="hidden md:block">{$t('delete_group')}</Text>
      </Button>
    </HStack>
  {/snippet}
  <div>
    <Container size="large" center>
      <div class="col-span-full flex gap-4 items-center my-4">
        <GroupAvatar {group} size="giant" />
        <div class="flex flex-col gap-1">
          <Heading tag="h1" size="large">{group.name}</Heading>
          {#if group.description}
            <Text color="muted">{group.description}</Text>
          {/if}
        </div>
      </div>
      <div>
        <Card color="secondary">
          <!-- <CardHeader>
            <div class="flex items-center gap-2 px-4 py-2 text-primary">
              <Icon icon={mdiAccountOutline} size="1.5rem" />
              <CardTitle>{$t('profile')}</CardTitle>
            </div>
          </CardHeader> -->
          <CardBody>
            <div class="px-4 pb-7">
              <Stack gap={2}>
                <div>
                  <Heading tag="h3" size="tiny">{$t('created_at')}</Heading>
                  <Text>{group.createdAt}</Text>
                </div>
                <div>
                  <Heading tag="h3" size="tiny">{$t('updated_at')}</Heading>
                  <Text>{group.updatedAt}</Text>
                </div>
                <div>
                  <Heading tag="h3" size="tiny">{$t('id')}</Heading>
                  <Code>{group.id}</Code>
                </div>
              </Stack>
            </div>
          </CardBody>
        </Card>
      </div>
    </Container>
  </div>
</AdminPageLayout>
